package com.example.be_bitstone.repository;

import com.example.be_bitstone.entity.Image;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ImageRepository extends JpaRepository<Image, Long> {
    @Query("""
        SELECT DISTINCT i
          FROM Image i
          JOIN FETCH i.detections d
         WHERE d.detectionClass.id IN :classIds
        """)
    List<Image> findAllWithDetectionsClassIds(@Param("classIds") List<Integer> classIds);
}
