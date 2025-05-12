package com.example.be_bitstone.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Entity
@Table(name = "detections")
public class Detection {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "image_id", nullable = false)
    private Long imageId;
    @Column(name = "x1")
    private Integer x1;
    @Column(name = "y1")
    private Integer y1;
    @Column(name = "x2")
    private Integer x2;
    @Column(name = "y2")
    private Integer y2;
    @Column(name = "class_id", nullable = false)
    private Integer classId;
    @Column(name = "class_name")
    private String className;
    @Column(name = "is_resolved")
    private Boolean isResolved = false;
    @Column(name = "resolved_at")
    private Date resolvedAt;

}