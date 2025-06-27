import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;
import static org.junit.jupiter.api.Assertions.*;

public class TestGreeter {
    private Greeter greeter;

    @BeforeEach
    public void setUp() {
        greeter = new Greeter();
    }

    @Test
    public void testGreetContainsName() {
        String result = greeter.greet("World");
        assertTrue(result.contains("World"));
    }

    @Test
    public void testGreetLength() {
        String result = greeter.greet("World");
        assertTrue(result.length() > 5);
    }
}