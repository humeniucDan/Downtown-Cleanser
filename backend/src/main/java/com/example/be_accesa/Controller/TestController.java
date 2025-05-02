package com.example.be_accesa.Controller;

import com.example.be_accesa.Service.RedisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/test")
public class TestController {
    @Autowired
    RedisService redisService;

    @PostMapping("/send")
    ResponseEntity<String> testPushToQueue(){
        redisService.enqueue("test de la Dan");
        return new ResponseEntity<>("ok", HttpStatus.OK);
    }
}
