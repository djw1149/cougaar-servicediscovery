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

package org.cougaar.servicediscovery.util;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

/**
 *  Parses wsdl documents with soap bindings.
 *
 *@author     HSingh
 *@version    $Id: WSDLParser.java,v 1.4 2003-12-09 18:02:26 rtomlinson Exp $
 */

public class WSDLParser extends DefaultHandler {

	public static void main(String argv[]) {
		if(argv.length != 1) {
			//System.err.println("Usage: WSDLParser [uri]");
			System.exit(1);
		}

		DefaultHandler handler = new WSDLParser();

		SAXParserFactory factory = SAXParserFactory.newInstance();
		try {
			// Parse the input
			SAXParser saxParser = factory.newSAXParser();
			saxParser.parse(argv[0], handler);
		} catch(Throwable t) {
			t.printStackTrace();
		}
		System.exit(0);
	}


	private WSDLObject wsdlObj;


	public WSDLParser() { }

	public WSDLParser(String uri) {
		this.wsdlObj = new WSDLObject(uri);
	}

	public WSDLObject getWSDLObject() {
		return this.wsdlObj;
	}


	public void startDocument() throws SAXException { }

	public void endDocument() throws SAXException { }


	public void startElement(String namespaceURI,
		String sName,
		String qName,
		Attributes attrs) throws SAXException {

		String eName = sName;

		if("".equals(eName)) {
			eName = qName;
		}

		handleElement(eName, attrs);
	}


	public void endElement(String namespaceURI,
		String sName,
		String qName) throws SAXException { }


	public void characters(char buf[], int offset, int len) throws SAXException { }


	private void handleElement(String elementName, Attributes attrs) throws SAXException {
		if(elementName.equals("soap:operation")) {
			wsdlObj.addMethod(getAttributeValue("soapAction", attrs));
		} else if(elementName.equals("soap:address")) {
			wsdlObj.setSoapLocation(getAttributeValue("location", attrs));
			wsdlObj.hasSoapBinding(true);
		} else if(elementName.equals("soap:body")) {
			wsdlObj.setTargetNameSpace(getAttributeValue("namespace", attrs));
			wsdlObj.setEncodingStyle(getAttributeValue("encodingStyle", attrs));
		} else {
			;
		}
	}


	private String getAttributeValue(String AttribName, Attributes attrs) {
		if(attrs != null) {
			for(int i = 0; i < attrs.getLength(); i++) {
				if(attrs.getQName(i).equals(AttribName)) {
					return attrs.getValue(i);
				} else {
					;
				}
			}
			return null;
		} else {
			return null;
		}

	}


	/**
	 *  Parses wsdl file and returns a filled out WSDLObject.
	 *
	 *@param  locationUri  URI pointing to the wsdl file in interest.
	 *@return              WSDLObject
	 */
	public WSDLObject parse(String locationUri) {
		this.wsdlObj = new WSDLObject(locationUri);

		SAXParserFactory factory = SAXParserFactory.newInstance();

		try {
			SAXParser saxParser = factory.newSAXParser();
			saxParser.parse(locationUri, this);

		} catch(Throwable t) {}

		return this.wsdlObj;
	}
}

