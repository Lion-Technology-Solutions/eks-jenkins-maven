package com.example;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class TestGreeter {
    private Greeter greeter;

    @BeforeEach
    public void setUp() {
        greeter = new Greeter();
    }

    @Test
    public void testGreet() {
        assertEquals("Hello, World!", greeter.greet("World"));
    }
}