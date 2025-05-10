package com.example.be_bitstone.entity;

import com.example.be_bitstone.dto.GpsDto;
import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Entity
@Table(name = "authorities")
public class Authority {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;
    @Column(name = "name")
    private String name;
    @Column(name = "hq_address")
    private String hqAddress;
    @Column(name = "rep_code")
    private String repCode;
    @Column(name = "accessible_problem_class_id")
    private Integer accessibleProblemClassId;
}
