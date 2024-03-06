package com.hainguyen.demodocker.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class home {
  @GetMapping("/")
  public String index() {
    return "Hello world, How are you?";
  }
}
