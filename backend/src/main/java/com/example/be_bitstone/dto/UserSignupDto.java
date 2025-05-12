package com.example.be_bitstone.dto;
import lombok.*;
import software.amazon.awssdk.services.s3.endpoints.internal.Value;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class UserSignupDto {
    private String email;
    private String fullName;
    private String password;
    private String repCode;
}
