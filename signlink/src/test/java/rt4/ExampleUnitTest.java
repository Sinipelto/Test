package rt4;

import static org.junit.Assert.fail;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertArrayEquals;

import java.io.File;
import java.io.IOException;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

public class ExampleUnitTest {
	@BeforeAll
	static void testClassInit() {
		File f = new File("testfile");
		f.delete();
	}

	@AfterAll
	static void testClassCleanup() {
		File f = new File("testfile");
		f.delete();
	}

	@Test
	void sampleTest() {
		assertEquals(2, 1+1);
	}

	@Test
	void fileOnDiskReadWriteTest() {
		File f = new File("testfile");
		FileOnDisk tc;
		byte[] in = new byte[]{8, 16, 32, 64, 127};
		byte[] out = new byte[in.length];
		assertEquals(in.length, out.length);
		try {
			tc = new FileOnDisk(f, "rw", 8);
			tc.write(in, in.length, 0);
			int r = tc.read(0, in.length, out);
			assertEquals(in.length, r);
		} catch (IOException ex) {
			fail("Could not operate FileOnDisk: " + ex.getMessage());
		}
		assertArrayEquals(in, out, "Data in and data out does not match!");
	}
}
