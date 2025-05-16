package com.example.be_bitstone.filter;

import com.example.be_bitstone.dto.UserTokenDto;
import com.example.be_bitstone.utils.JWTService.JWTParser;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Component
public class AuthFilter extends OncePerRequestFilter {
    private final List<String> allowedPaths = Arrays.asList(
            "/login",
            "/signup",
            "/ver",
            "/authority/register"
    );
    @Autowired
    private JWTParser jwtParser;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        response.setHeader("Access-Control-Allow-Origin", request.getHeader("Origin"));
        System.out.println(request.getHeader("Origin"));
        response.setHeader("Access-Control-Allow-Credentials", "true");
        response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
        response.setHeader("Access-Control-Max-Age", "3600");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type, Accept, X-Requested-With, remember-me");

        if(request.getMethod().equals("OPTIONS")){
            response.setStatus(HttpServletResponse.SC_OK);
            return;
        }

        String path = request.getRequestURI();
        String context = request.getContextPath();
        String relativePath = path.substring(context.length());

        if(relativePath.equals("/login") || relativePath.equals("/signup") || relativePath.equals("/ver")){
            filterChain.doFilter(request, response);
            return;
        }

        Cookie wantedCookie = null;
        Cookie[] cookies = request.getCookies();
        if(cookies == null) {
            System.out.println(relativePath);
            System.out.println("cookies is null");
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied: Invalid or Missing Credentials");
            return;
        }

        for(Cookie cookie: cookies) {
            if("jwToken".equals(cookie.getName()))
                wantedCookie = cookie;
        }
        if (wantedCookie == null){
            System.out.println("wantedCookie is null");
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied: Invalid or Missing Credentials");
            return;
        }

        System.out.println("Wanted cookie: " + wantedCookie.getValue());

        UserTokenDto authDTO = null;
        try {
            authDTO = jwtParser.validateAndParseToken(wantedCookie.getValue());
        } catch (Exception e) {
            System.out.println(e.getMessage());
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied: Invalid or Missing Credentials");
        }
        System.out.println("Cookie valid");
        request.setAttribute("authData", authDTO);

        filterChain.doFilter(request, response);
    }
}
