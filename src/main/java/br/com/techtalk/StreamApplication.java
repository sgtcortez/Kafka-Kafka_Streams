package br.com.techtalk;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.kafka.common.serialization.Serdes;
import org.apache.kafka.streams.StreamsBuilder;
import org.apache.kafka.streams.kstream.*;

@Slf4j
@AllArgsConstructor
public class StreamApplication {

    private static final String CUSTOMER_CONTACT = "CUSTOMER";
    private static final String CUSTOMER_ADDRESS = "CUSTOMER-ADDRESS";
    private static final String ORDER = "ORDER";
    private static final String ITEM = "ITEM";
    private static final String ORDER_MAIL = "ORDER-MAIL";

    private static final CustomerJoiner CUSTOMER_JOINER = new CustomerJoiner();
    private static final CustomerOrderJoiner CUSTOMER_ORDER_JOINER = new CustomerOrderJoiner();


    public StreamApplication(final StreamsBuilder builder) {
        process(builder);
    }

    private void process(final StreamsBuilder builder) {
        final var contact = customerContact(builder);
        final var address = customerAddress(builder);

        final var order = order(builder);

        final var item = item(builder);

        // TOPIC CONTACT & TOPIC ADDRESS has the key as the customer id
        // so, we can make the join as simply as is
        // both contact and address events will trigger this join
        final var customerEnriched = contact.join(address, CUSTOMER_JOINER);

        // just the order event will trigger this.
        // gets the new key from order
        order.selectKey((key, value) -> value.getCustomerId().toString())
                .join(
                        customerEnriched,
                        CUSTOMER_ORDER_JOINER
                )
                .peek((key, value) -> log.info("Joined Customer x Order"))
                // JOINS WITH THE table of items
                .join(
                        item,
                        (key, value) -> value.getItemId().toString(), // SELECT THE KEY TO JOIN WITH THE GLOBAL GLOBAL KTABLE
                        ((value1, value2) ->
                                String.format("Order: %s. Item: %s", value1.toString(), value2.toString())
                        ))
                .peek((key, value) -> log.info("Joined Order x ITEM. {}", value))
                .to(
                        ORDER_MAIL,
                        Produced.with(
                                Serdes.String(),
                                Serdes.String()
                        )
                );

    }

    private KTable<String, Customer> customerContact(final StreamsBuilder streamsBuilder) {
        return streamsBuilder
                .table(
                        CUSTOMER_CONTACT,
                        Consumed.with(
                                Serdes.String(),
                                CustomSerdes.jsonSerdes(Customer.class)
                        )
                );
    }

    private KTable<String, CustomerAddress> customerAddress(final StreamsBuilder streamsBuilder) {
        return streamsBuilder
                .table(
                        CUSTOMER_ADDRESS,
                        Consumed.with(
                                Serdes.String(),
                                CustomSerdes.jsonSerdes(CustomerAddress.class)
                        )
                );
    }

    private KStream<String, Order> order(final StreamsBuilder streamsBuilder) {
        return streamsBuilder
                .stream(
                        ORDER,
                        Consumed.with(
                                Serdes.String(),
                                CustomSerdes.jsonSerdes(Order.class)
                        )
                ) // it is possible to decide which partition consumer
                .peek((key, value) -> log.info(
                        "Received message on {}. Key: {} Value: {}",
                        ORDER,
                        key,
                        value
                        )
                );
    }

    private GlobalKTable<String, Item> item(final StreamsBuilder streamsBuilder) {
        return streamsBuilder
                .globalTable(
                        ITEM,
                        Consumed.with(
                                Serdes.String(),
                                CustomSerdes.jsonSerdes(Item.class)
                        )
                );
    }


}
