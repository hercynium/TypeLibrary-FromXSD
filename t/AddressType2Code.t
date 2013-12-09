#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;
use TypeLibrary::FromXSD::Element;
use XML::LibXML;

my $xsd_element = qq!<?xml version="1.0" encoding="UTF-8"?>
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="urn:sepade:xsd:pain.001.001.02" targetNamespace="urn:sepade:xsd:pain.001.001.02" elementFormDefault="qualified">
  <xs:simpleType name="AddressType2Code">
    <xs:restriction base="xs:string">
      <xs:enumeration value="ADDR"/>
      <xs:enumeration value="PBOX"/>
      <xs:enumeration value="HOME"/>
      <xs:enumeration value="BIZZ"/>
      <xs:enumeration value="MLTO"/>
      <xs:enumeration value="DLVY"/>
    </xs:restriction>
  </xs:simpleType>
</xs:schema>!;

my ($node)  = XML::LibXML->new->parse_string( $xsd_element )->getDocumentElement->getElementsByTagName( 'xs:simpleType' );
my $element = TypeLibrary::FromXSD::Element->new( $node );

my $check   = qq!declare AddressType2Code =>
    as enum ['ADDR','PBOX','HOME','BIZZ','MLTO','DLVY'];!;
is $element->type, $check;

done_testing(); 
