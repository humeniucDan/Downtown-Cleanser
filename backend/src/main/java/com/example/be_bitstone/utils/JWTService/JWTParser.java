package com.example.be_bitstone.utils.JWTService;

import com.example.be_bitstone.dto.UserTokenDto;
import com.example.be_bitstone.entity.User;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import org.springframework.stereotype.Service;


@Service
public class JWTParser extends JWTUtil {
    public UserTokenDto validateAndParseToken(String token) {
        // Verify and parse the token
        Jws<Claims> claimsJws = Jwts.parser()
                .verifyWith(this.getSecretKey()) // From parent JWTUtil class
                .build()
                .parseSignedClaims(token);

        // Extract claims
        Claims claims = claimsJws.getPayload();

        // Create and populate User object
        UserTokenDto user = new UserTokenDto();
        user.setId(claims.get("id", Long.class));
        user.setEmail(claims.get("email", String.class));

        return user;
    }
}