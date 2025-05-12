package com.example.be_bitstone.repository;

import com.example.be_bitstone.entity.Detection;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface DetectionRepository extends JpaRepository<Detection, Long> {
    Optional<Detection> findById(Long id);
}
