package org.infinispan.stress;

import java.util.concurrent.TimeUnit;

import org.infinispan.configuration.cache.ConfigurationBuilder;
import org.testng.annotations.Test;

/**
 * @author Pedro Ruivo
 * @since 7.0
 */
@Test(testName = "stress.DistL1WriteSkewStressTest", groups = "stress")
public class DistL1WriteSkewStressTest extends DistWriteSkewStressTest {

   @Override
   protected void decorate(ConfigurationBuilder builder) {
      // Enable L1
      builder.clustering().l1().enable();
      builder.clustering().remoteTimeout(100, TimeUnit.MINUTES);
   }
}
