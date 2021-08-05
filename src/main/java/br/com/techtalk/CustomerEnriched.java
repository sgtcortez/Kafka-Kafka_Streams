package br.com.techtalk;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class CustomerEnriched {

    // Represents the union of customer address and customer contact
    private Long id;
    private String email;
    private String name;
    private String city;

}
