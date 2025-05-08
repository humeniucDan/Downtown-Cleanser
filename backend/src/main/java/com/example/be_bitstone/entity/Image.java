package com.example.be_bitstone.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.Date;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Entity
@Table(name = "images")
public class Image {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "posted_at", nullable = false)
    private Date postedAt;
    @Column(name = "posted_by", nullable = false)
    private Long postedBy;
    @Column(name = "is_processed", nullable = false)
    private boolean isProcessed = false;
    @Column(name = "processed_at")
    private Date processedAt;
    @Column(name = "is_resolved")
    private boolean isResolved = false;
    @Column(name = "resolved_at")
    private Date resolvedAt;
    @Column(name = "raw_image_url")
    private String rawImageUrl;
    @Column(name = "annotated_image_url")
    private String annotatedImageUrl;
    @Column(name = "lat")
    private Double lat;
    @Column(name = "lng")
    private Double lng;
    @Column(name = "file_name")
    private String fileName;
    @OneToMany
    @JoinColumn(name = "photo_id")
    private List<Detection> detections;
}
