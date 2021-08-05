package br.com.techtalk;

import org.apache.kafka.streams.kstream.ValueJoiner;

public final class CustomerJoiner implements ValueJoiner<Customer, CustomerAddress, CustomerEnriched> {

    @Override
    public CustomerEnriched apply(Customer customer, CustomerAddress address) {
        return CustomerEnriched
                .builder()
                .id(customer.getId())
                .name(customer.getName())
                .email(customer.getEmail())
                .city(address.getCity())
                .build();
    }
}

