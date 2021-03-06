/*
 * <copyright>
 *  
 *  Copyright 2002-2004 BBNT Solutions, LLC
 *  under sponsorship of the Defense Advanced Research Projects
 *  Agency (DARPA).
 * 
 *  You can redistribute this software and/or modify it under the
 *  terms of the Cougaar Open Source License as published on the
 *  Cougaar Open Source Website (www.cougaar.org).
 * 
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *  
 * </copyright>
 */

package org.cougaar.servicediscovery.description;


public class ServiceClassificationImpl implements ServiceClassification, java.io.Serializable {

  private String code;
  private String name;
  private String scheme;

  public ServiceClassificationImpl() {
  }

  public ServiceClassificationImpl(String code, String name, String scheme){
    this.code = code;
    this.name = name;
    this.scheme = scheme;
  }

  public String getClassificationName() {
    return name;
  }

  public String getClassificationCode() {
    return code;
  }

  public String getClassificationSchemeName() {
    return scheme;
  }

  public void setClassificationName(String name) {
    this.name = name;
  }

  public void setClassificationCode(String code) {
    this.code = code;
  }

  public void setClassificationSchemeName(String scheme) {
    this.scheme = scheme;
  }

  public String toString() {
    String ret = "ServiceClassification(scheme: " + this.getClassificationSchemeName() + " name: " +
                 this.getClassificationName() + " code: " + this.getClassificationCode() + ")";
    return ret;
  }
}
