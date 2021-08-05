package br.com.techtalk;

import org.apache.kafka.streams.kstream.ValueJoiner;

public class CustomerOrderJoiner implements ValueJoiner<Order, CustomerEnriched, OrderEnriched> {

    @Override
    public OrderEnriched apply(Order order, CustomerEnriched customer) {
        return OrderEnriched
                .builder()
                .customerCity(customer.getCity())
                .itemId(order.getItemId())
                .customerName(customer.getName())
                .customerEmail(customer.getEmail())
                .id(order.getId())
                .build();
    }
}
