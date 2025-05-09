package com.example.be_bitstone.utils.JWTService;

import com.example.be_bitstone.dto.UserTokenDto;
import com.example.be_bitstone.entity.User;
import io.jsonwebtoken.Jwts;
import org.springframework.stereotype.Service;
import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.Map;

@Service
public class JWTGenerator extends JWTUtil {
    public String generateToken(User userData) {
        Map<String, Object> claims = extractClaims(userData);
        claims.remove("images");
        claims.remove("password");
        claims.remove("fullName");
        return Jwts.builder()
                .claims(claims)
                .signWith(this.getSecretKey())
                .compact();
    }

    private Map<String, Object> extractClaims(Object object) {
        Map<String, Object> claims = new HashMap<>();
        Field[] fields = object.getClass().getDeclaredFields();

        for (Field field : fields) {
            field.setAccessible(true);
            try {
                claims.put(field.getName(), field.get(object));
            } catch (IllegalAccessException e) {
                throw new RuntimeException("Error extracting claims via reflection", e);
            }
            field.setAccessible(false);
        }
        return claims;
    }
}
