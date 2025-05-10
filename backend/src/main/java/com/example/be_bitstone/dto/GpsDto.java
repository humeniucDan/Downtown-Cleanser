package com.example.be_bitstone.dto;

import jakarta.persistence.Embeddable;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class GpsDto {
    private Double lat;
    private Double lng;
}
