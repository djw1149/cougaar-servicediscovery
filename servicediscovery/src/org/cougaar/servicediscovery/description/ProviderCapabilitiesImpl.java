/*
 * <copyright>
 *  Copyright 2002-2003 BBNT Solutions, LLC
 *  under sponsorship of the Defense Advanced Research Projects Agency (DARPA)
 *  and the Defense Logistics Agency (DLA).
 * 
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the Cougaar Open Source License as published by
 *  DARPA on the Cougaar Open Source Website (www.cougaar.org).
 * 
 *  THE COUGAAR SOFTWARE AND ANY DERIVATIVE SUPPLIED BY LICENSOR IS
 *  PROVIDED 'AS IS' WITHOUT WARRANTIES OF ANY KIND, WHETHER EXPRESS OR
 *  IMPLIED, INCLUDING (BUT NOT LIMITED TO) ALL IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, AND WITHOUT
 *  ANY WARRANTIES AS TO NON-INFRINGEMENT.  IN NO EVENT SHALL COPYRIGHT
 *  HOLDER BE LIABLE FOR ANY DIRECT, SPECIAL, INDIRECT OR CONSEQUENTIAL
 *  DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE OF DATA OR PROFITS,
 *  TORTIOUS CONDUCT, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *  PERFORMANCE OF THE COUGAAR SOFTWARE.
 * </copyright>
 */
package org.cougaar.servicediscovery.description;

import org.cougaar.core.util.UID;
import org.cougaar.planning.ldm.plan.Role;
import org.cougaar.planning.ldm.plan.Schedule;
import org.cougaar.util.log.Logger;
import org.cougaar.util.log.Logging;

import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
/**
 * Maintains the set of provider capabilities
 */


public class ProviderCapabilitiesImpl implements ProviderCapabilities {
  private static Logger logger = Logging.getLogger(ProviderCapabilitiesImpl.class);
  private UID myUID = null;
  
  private HashMap myCapabilities = null;
  private String myProviderName = null;


  public ProviderCapabilitiesImpl() {
    this(null);
  }

  public ProviderCapabilitiesImpl(String providerName) {
    myProviderName = providerName;
    myCapabilities = new HashMap();
  }

  /**
   * @return the name of the provider
   **/
  public String getProviderName() {
    return myProviderName;
  }

  /**
   * @param providerName
   **/
  public void setProviderName(String providerName) {
    // Not allowed to set name more than once
    if (myProviderName != null) {
      logger.error(myProviderName + ":Attempt to reset provider name.");
      return;
    } 
    myProviderName = providerName;
  }

  /**
   * @return all provider capabilities
   */ 
  public Collection  getCapabilities() {
    return Collections.unmodifiableCollection(myCapabilities.values());
  }

  /**
   * @return provider capability for a specific Role
   */ 
  public ProviderCapability getCapability(Role role) {
    return (ProviderCapability) myCapabilities.get(role);
  }

  /**
   * Add a provider capability
   * @param role
   * @param echelon
   * @param availableSchedule
   */
   public void addCapability(Role role, String echelon, 
			     Schedule availableSchedule) {
     addCapability(new ProviderCapabilityImpl(role, echelon, availableSchedule));
   }

  public void addCapability(ProviderCapability capability) {
    if (logger.isDebugEnabled()) {
      ProviderCapability current = 
	(ProviderCapability) myCapabilities.get(capability.getRole());
      if (current != null) {
	logger.debug(getProviderName() + " replacing capability " + current +
		     " with " + capability);
      } else {
	logger.debug(getProviderName() + " added capability " + capability);
      }
    }
    myCapabilities.put(capability.getRole(), capability);
  }

  public void removeCapability(ProviderCapability capability) {
    if (logger.isDebugEnabled()) {
      logger.debug(getProviderName() + " removed capability " + capability);
    }
    myCapabilities.remove(capability.getRole());
  }

  public void setUID(UID newUID) {
    if (myUID != null) {
      logger.error("Attempt to reset UID.");
      return;
    } 
      
    myUID = newUID;
  }

  public UID getUID() {
    return myUID;
  }
 }