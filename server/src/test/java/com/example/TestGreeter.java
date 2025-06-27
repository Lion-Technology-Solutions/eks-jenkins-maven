package com.example;

import static org.junit.jupiter.api.Assertions.*;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class TestGreeter {
    private Greeter greeter;

    @BeforeEach
    public void setUp() {
        greeter = new Greeter();
    }

    @Test
    public void testGreet() {
        String result = greeter.greet("World");
        assertEquals("Hello, World!", result);
    }

    @Test
    public void testGreetContainsName() {
        String result = greeter.greet("World");
        assertThat(result, containsString("World"));
    }

    @Test
    public void testGreetLength() {
        String result = greeter.greet("World");
        assertThat(result.length(), greaterThan(5));
    }
}