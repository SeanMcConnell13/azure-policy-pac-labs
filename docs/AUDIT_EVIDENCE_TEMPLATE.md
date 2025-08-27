\# Control Evidence – Example Packet



\## Control ID

CIS 1.1 / NIST AC-3 – Restrict resource deployment regions



\## Implementation

\- Azure Policy: `Allowed Locations` (custom policy)

\- Assignment scope: Subscription `<SUB\_ID>`

\- Parameters: `allowedLocations = \["eastus","centralus"]`



\## Operating Effectiveness

\- Attempted creation of a VM in `westus` → \*\*Denied\*\* (screenshot attached)

\- Policy Compliance export attached (CSV/PDF)



\## Continuous Monitoring

\- Azure Policy Compliance scan (continuous)

\- Microsoft Defender for Cloud Secure Score tracking



\## Exceptions/Compensating Controls

\- None at this time



