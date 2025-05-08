package com.example.be_bitstone.repository;

import com.example.be_bitstone.entity.Image;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ImageRepository extends JpaRepository<Image, Long> {
}
