// src/main/java/com/example/be_bitstone/config/RedisConfig.java
package com.example.be_bitstone.config;

import com.example.be_bitstone.service.FilebaseService;
import com.example.be_bitstone.service.RedisConsumerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.connection.RedisStandaloneConfiguration;
import org.springframework.data.redis.connection.lettuce.LettuceConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.listener.PatternTopic;
import org.springframework.data.redis.listener.RedisMessageListenerContainer;
import org.springframework.data.redis.listener.adapter.MessageListenerAdapter;
import org.springframework.data.redis.serializer.StringRedisSerializer;

/**
 * Redis configuration: sets up a listener container that delegates messages
 * on the 'queue:ack' topic to RedisConsumerService.onMessage.
 */
@Configuration
public class RedisConfig {
    private static final String ACK_QUEUE = "queue:ack";

    @Autowired
    private FilebaseService filebaseService;

    @Value("${spring.data.redis.host}")  // Use a more specific prefix
    private String redisHost;

    @Value("${spring.data.redis.port}")  // Use a more specific prefix
    private int redisPort;

    @Value("${spring.data.redis.password}")  // Use a more specific prefix
    private String redisPassword;

    @Value("${spring.data.redis.username}")  // Use a more specific prefix
    private String redisUsername;


    @Bean
    public RedisConnectionFactory redisConnectionFactory() {
        RedisStandaloneConfiguration config = new RedisStandaloneConfiguration(redisHost, redisPort);
        config.setUsername(redisUsername);
        config.setPassword(redisPassword);
        return new LettuceConnectionFactory(config);
    }

    /**
     * Configure the listener container, wiring the listener adapter and topic.
     */
    @Bean
    public RedisMessageListenerContainer container(RedisConnectionFactory connectionFactory,
                                                   MessageListenerAdapter listenerAdapter) {
        RedisMessageListenerContainer container = new RedisMessageListenerContainer();
        container.setConnectionFactory(connectionFactory);
        // Subscribe to the ACK_QUEUE topic
        container.addMessageListener(listenerAdapter, new PatternTopic(ACK_QUEUE));
        return container;
    }

    /**
     * Create a listener adapter that delegates to the RedisConsumerService bean's onMessage method.
     * Important: inject the existing bean rather than creating a new instance.
     */
    @Bean
    public MessageListenerAdapter listenerAdapter(RedisConsumerService consumerService) {
        // 'onMessage' is the method name in RedisConsumerService
        return new MessageListenerAdapter(consumerService, "onMessage");
    }

    /**
     * Template for publishing and reading string messages.
     */
    @Bean
    public StringRedisTemplate template(RedisConnectionFactory connectionFactory) {
        return new StringRedisTemplate(connectionFactory);
    }
//    @Bean
//    public RedisTemplate<String, Object> redisTemplate(RedisConnectionFactory redisConnectionFactory) {
//        RedisTemplate<String, Object> template = new RedisTemplate<>();
//        template.setConnectionFactory(redisConnectionFactory);
//
//        // Use StringRedisSerializer for keys
//        template.setKeySerializer(new StringRedisSerializer());
//        template.setHashKeySerializer(new StringRedisSerializer());
//
//        // Add serializers for value (if needed, e.g., Jackson2JsonRedisSerializer for JSON)
//        // template.setValueSerializer(new Jackson2JsonRedisSerializer<>(Object.class));
//        // template.setHashValueSerializer(new Jackson2JsonRedisSerializer<>(Object.class));
//        // If you're using simple strings as values, you can use StringRedisSerializer:
//        template.setValueSerializer(new StringRedisSerializer());
//        template.setHashValueSerializer(new StringRedisSerializer());
//
//
//        template.afterPropertiesSet(); // Important: Initialize the template
//        return template;
//    }
}