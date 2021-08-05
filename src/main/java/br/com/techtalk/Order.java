package br.com.techtalk;

import lombok.Data;

@Data
public class Order {

    private Long id;
    private Long customerId;
    private Long itemId;

}
