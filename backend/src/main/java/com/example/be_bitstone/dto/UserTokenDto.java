package com.example.be_bitstone.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class UserTokenDto {
    private Long id;
    private String email;
    private Boolean isAdmin;
    private Boolean isRep;
    private Long repAuthorityId;
}
