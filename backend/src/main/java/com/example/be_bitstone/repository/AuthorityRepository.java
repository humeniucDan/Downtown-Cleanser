package com.example.be_bitstone.repository;

import com.example.be_bitstone.entity.Authority;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface AuthorityRepository extends JpaRepository<Authority, Long> {
    Optional<Authority> findByRepCode(String repCode);
    Optional<Authority> findByCui(String cui);
}
