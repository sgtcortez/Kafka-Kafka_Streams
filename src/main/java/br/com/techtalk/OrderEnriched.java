package br.com.techtalk;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class OrderEnriched {

    private Long id;
    private String customerName;
    private String customerCity;
    private String customerEmail;
    private Long itemId;
}
