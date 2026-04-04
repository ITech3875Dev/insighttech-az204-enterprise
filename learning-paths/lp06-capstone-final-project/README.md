# LP06 - Capstone Final Project

## Project Scope
This learning path contains the integrated final project that combines all AZ-104 domains into one enterprise landing zone implementation.

## Capstone Track
- `masterclass/enterprise-landing-zone/README.md`

## Objective
Build a hub-and-spoke landing zone with governance guardrails, secure transit through OPNsense NVA, monitoring and backup coverage, and evidence-driven validation.

## Mandatory Validation Requirement
Students must deploy a validation VM in a spoke subnet and prove both outcomes:
- Spoke VM can connect to approved hub endpoint(s)
- Spoke VM cannot access direct internet destinations

All spoke traffic must be forced to hub for inspection and policy enforcement.

## Delivery Model
- Command-first implementation (CLI, PowerShell, Bicep)
- Portal exception only for OPNsense Marketplace deployment

## Status
- Capstone masterclass implemented
- Topology and requirements documented
- OPNsense deployment and hardening workflow documented
- Spoke VM forced-tunnel validation workflow documented
