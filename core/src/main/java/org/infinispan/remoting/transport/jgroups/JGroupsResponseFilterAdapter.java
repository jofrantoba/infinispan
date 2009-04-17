package org.infinispan.remoting.transport.jgroups;

import org.infinispan.remoting.ResponseFilter;
import org.infinispan.remoting.responses.Response;
import org.jgroups.Address;
import org.jgroups.blocks.RspFilter;

/**
 * Acts as a bridge between JGroups RspFilter and {@link org.infinispan.remoting.ResponseFilter}.
 *
 * @author Manik Surtani
 * @since 4.0
 */
public class JGroupsResponseFilterAdapter implements RspFilter {

   ResponseFilter r;

   /**
    * Creates an instance of the adapter
    *
    * @param r response filter to wrap
    */
   public JGroupsResponseFilterAdapter(ResponseFilter r) {
      this.r = r;
   }

   public boolean isAcceptable(Object response, Address sender) {
      return r.isAcceptable((Response) response, new JGroupsAddress(sender));
   }

   public boolean needMoreResponses() {
      return r.needMoreResponses();
   }
}
