package com.example.be_bitstone.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.*;

import java.util.List;

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
    @Column(name = "name", nullable = false)
    private String name;
    @Column(name = "email", nullable = false)
    private String email;
    @Column(name = "hq_address")
    private String hqAddress;
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @Column(name = "cui", nullable = false, unique = true)
    private String cui;
    @JsonIgnore
    @Column(name = "rep_code", nullable = false, unique = true)
    private String repCode;
    @Column(name = "password", nullable = false)
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private String password;
    @Column(name = "accessible_problem_class_id")
    @ElementCollection
    private List<Long> accessibleProblemClassIds;
}
