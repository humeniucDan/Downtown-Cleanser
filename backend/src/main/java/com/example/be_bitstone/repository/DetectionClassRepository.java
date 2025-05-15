package com.example.be_bitstone.repository;

import com.example.be_bitstone.entity.DetectionClass;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DetectionClassRepository extends JpaRepository<DetectionClass, Integer> {
}
