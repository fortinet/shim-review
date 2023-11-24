This repo is for review of requests for signing shim.  To create a request for review:

- clone this repo
- edit the template below
- add the shim.efi to be signed
- add build logs
- add any additional binaries/certificates/SHA256 hashes that may be needed
- commit all of that
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"
- push that to github
- file an issue at https://github.com/rhboot/shim-review/issues with a link to your tag
- approval is ready when the "accepted" label is added to your issue

Note that we really only have experience with using GRUB2 on Linux, so asking
us to endorse anything else for signing is going to require some convincing on
your part.

Check the docs directory in this repo for guidance on submission and
getting your shim signed.

Here's the template:

*******************************************************************************
### What organization or people are asking to have this signed?
*******************************************************************************
Fortinet

*******************************************************************************
### What product or service is this for?
*******************************************************************************
FortiOS

*******************************************************************************
### What's the justification that this really does need to be signed for the whole world to be able to boot it?
*******************************************************************************
FortiOS is a linux based Firewall software. We want to support our users to boot FortiOS with secure boot enabled.

*******************************************************************************
### Why are you unable to reuse shim from another distro that is already signed?
*******************************************************************************
Reusing another distro's shim would require reusing their grub and kernel as well. We need to build our own kernel, so this would not work.

*******************************************************************************
### Who is the primary contact for security updates, etc.?
The security contacts need to be verified before the shim can be accepted. For subsequent requests, contact verification is only necessary if the security contacts or their PGP keys have changed since the last successful verification.

An authorized reviewer will initiate contact verification by sending each security contact a PGP-encrypted email containing random words.
You will be asked to post the contents of these mails in your `shim-review` issue to prove ownership of the email addresses and PGP keys.
*******************************************************************************
- Name: Colin Wen
- Position: Senior Director Software Development
- Email address: gwen@fortinet.com
- PGP key fingerprint: 3819 A333 7DC9 07A5 624C  EC0B B1A6 BCD1 BB92 76D8

(Key should be signed by the other security contacts, pushed to a keyserver
like keyserver.ubuntu.com, and preferably have signatures that are reasonably
well known in the Linux community.)

*******************************************************************************
### Who is the secondary contact for security updates, etc.?
*******************************************************************************
- Name: Lingbo Zou
- Position: Senior Software Engineer
- Email address: lzou@fortinet.com
- PGP key fingerprint: 94A4 E88B 4819 C5D8 5262  8513 7712 F4D0 F3CF 3EA7

(Key should be signed by the other security contacts, pushed to a keyserver
like keyserver.ubuntu.com, and preferably have signatures that are reasonably
well known in the Linux community.)

*******************************************************************************
### Were these binaries created from the 15.7 shim release tar?
Please create your shim binaries starting with the 15.7 shim release tar file: https://github.com/rhboot/shim/releases/download/15.7/shim-15.7.tar.bz2

This matches https://github.com/rhboot/shim/releases/tag/15.7 and contains the appropriate gnu-efi source.

*******************************************************************************
We confirm that our shim binaries are built from the referenced tarball.

*******************************************************************************
### URL for a repo that contains the exact code which was built to get this binary:
*******************************************************************************
https://github.com/rhboot/shim/tree/15.7

*******************************************************************************
### What patches are being applied and why:
*******************************************************************************
No patches are applied

*******************************************************************************
### If shim is loading GRUB2 bootloader what exact implementation of Secureboot in GRUB2 do you have? (Either Upstream GRUB2 shim_lock verifier or Downstream RHEL/Fedora/Debian/Canonical-like implementation)
*******************************************************************************
Upstream GRUB2 2.06 with shim_lock verifier. This verifier is included as long as --disable-shim-lock wasn't passed to grub-mkimage (and we do not set that flag). The verifier is enabled automatically when UEFI Secure Boot is enabled. Reference:
https://www.gnu.org/software/grub/manual/grub/html_node/UEFI-secure-boot-and-shim.html

*******************************************************************************
### If shim is loading GRUB2 bootloader and your previously released shim booted a version of GRUB2 affected by any of the CVEs in the July 2020, the March 2021, the June 7th 2022, the November 15th 2022, or 3rd of October 2023 GRUB2 CVE list, have fixes for all these CVEs been applied?

* 2020 July - BootHole
  * Details: https://lists.gnu.org/archive/html/grub-devel/2020-07/msg00034.html
  * CVE-2020-10713
  * CVE-2020-14308
  * CVE-2020-14309
  * CVE-2020-14310
  * CVE-2020-14311
  * CVE-2020-15705
  * CVE-2020-15706
  * CVE-2020-15707
* March 2021
  * Details: https://lists.gnu.org/archive/html/grub-devel/2021-03/msg00007.html
  * CVE-2020-14372
  * CVE-2020-25632
  * CVE-2020-25647
  * CVE-2020-27749
  * CVE-2020-27779
  * CVE-2021-3418 (if you are shipping the shim_lock module)
  * CVE-2021-20225
  * CVE-2021-20233
* June 2022
  * Details: https://lists.gnu.org/archive/html/grub-devel/2022-06/msg00035.html, SBAT increase to 2
  * CVE-2021-3695
  * CVE-2021-3696
  * CVE-2021-3697
  * CVE-2022-28733
  * CVE-2022-28734
  * CVE-2022-28735
  * CVE-2022-28736
  * CVE-2022-28737
* November 2022
  * Details: https://lists.gnu.org/archive/html/grub-devel/2022-11/msg00059.html, SBAT increase to 3
  * CVE-2022-2601
  * CVE-2022-3775
* October 2023 - NTFS vulnerabilities
  * Details: https://lists.gnu.org/archive/html/grub-devel/2023-10/msg00028.html, SBAT increase to 4
  * CVE-2023-4693
  * CVE-2023-4692
*******************************************************************************
Yes.

*******************************************************************************
### If these fixes have been applied, is the upstream global SBAT generation in your GRUB2 binary set to 4?
The entry should look similar to: `grub,4,Free Software Foundation,grub,GRUB_UPSTREAM_VERSION,https://www.gnu.org/software/grub/`
*******************************************************************************
Yes.

*******************************************************************************
### Were old shims hashes provided to Microsoft for verification and to be added to future DBX updates?
### Does your new chain of trust disallow booting old GRUB2 builds affected by the CVEs?
*******************************************************************************
This is our first shim submission, this shim build disallow booting old GRUB2 builds affected by the CVEs.

*******************************************************************************
### If your boot chain of trust includes a Linux kernel:
### Is upstream commit [1957a85b0032a81e6482ca4aab883643b8dae06e "efi: Restrict efivar_ssdt_load when the kernel is locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1957a85b0032a81e6482ca4aab883643b8dae06e) applied?
### Is upstream commit [75b0cea7bf307f362057cc778efe89af4c615354 "ACPI: configfs: Disallow loading ACPI tables when locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=75b0cea7bf307f362057cc778efe89af4c615354) applied?
### Is upstream commit [eadb2f47a3ced5c64b23b90fd2a3463f63726066 "lockdown: also lock down previous kgdb use"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eadb2f47a3ced5c64b23b90fd2a3463f63726066) applied?
*******************************************************************************
Yes, all three commits are applied.

*******************************************************************************
### Do you build your signed kernel with additional local patches? What do they do?
*******************************************************************************
We have some local kernel patches to provide firewall services that are not in standard linux kernel.

*******************************************************************************
### Do you use an ephemeral key for signing kernel modules?
### If not, please describe how you ensure that one kernel build does not load modules built for another kernel.
*******************************************************************************
Yes, FortiOS uses ephemeral key for signing kernel module.

*******************************************************************************
### If you use vendor_db functionality of providing multiple certificates and/or hashes please briefly describe your certificate setup.
### If there are allow-listed hashes please provide exact binaries for which hashes are created via file sharing service, available in public with anonymous access for verification.
*******************************************************************************
We do not use vendor_db functionality.

*******************************************************************************
### If you are re-using a previously used (CA) certificate, you will need to add the hashes of the previous GRUB2 binaries exposed to the CVEs to vendor_dbx in shim in order to prevent GRUB2 from being able to chainload those older GRUB2 binaries. If you are changing to a new (CA) certificate, this does not apply.
### Please describe your strategy.
*******************************************************************************
This is our first shim submission.

*******************************************************************************
### What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as closely as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
### If the shim binaries can't be reproduced using the provided Dockerfile, please explain why that's the case and what the differences would be.
*******************************************************************************
Dockerfile to reproduce this build is included.

*******************************************************************************
### Which files in this repo are the logs for your build?
This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
*******************************************************************************
build_log.txt

*******************************************************************************
### What changes were made since your SHIM was last signed?
*******************************************************************************
This is our first shim submission.

*******************************************************************************
### What is the SHA256 hash of your final SHIM binary?
*******************************************************************************
476c554e0c06c419083f2868bd58e2e9c3774a763f4f37b935b3537f450843d2  shimx64.efi
ed64851489b8c77a54a79aba5f9969cfffaf3f47455008f11511c45225c69ea5  shimaa64.efi

*******************************************************************************
### How do you manage and protect the keys used in your SHIM?
*******************************************************************************
The keys are stored on HSM with restricted access.

*******************************************************************************
### Do you use EV certificates as embedded certificates in the SHIM?
*******************************************************************************
No.

*******************************************************************************
### Do you add a vendor-specific SBAT entry to the SBAT section in each binary that supports SBAT metadata ( GRUB2, fwupd, fwupdate, shim + all child shim binaries )?
### Please provide exact SBAT entries for all SBAT binaries you are booting or planning to boot directly through shim.
### Where your code is only slightly modified from an upstream vendor's, please also preserve their SBAT entries to simplify revocation.
If you are using a downstream implementation of GRUB2 (e.g. from Fedora or Debian), please
preserve the SBAT entry from those distributions and only append your own.
More information on how SBAT works can be found [here](https://github.com/rhboot/shim/blob/main/SBAT.md).
*******************************************************************************
shim:  
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md  
shim,3,UEFI shim,shim,1,https://github.com/rhboot/shim  
shim.fortios,1,Fortinet,shim,15.7,https://github.com/fortinet/shim-review  

grub:  
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md  
grub,4,Free Software Foundation,grub,2.06,https://www.gnu.org/software/grub/  
grub.fortios,1,Fortinet,grub2,2.06,https://www.fortinet.com/  
*******************************************************************************
### Which modules are built into your signed GRUB2 image?
*******************************************************************************
normal search configfile part_msdos part_gpt fat ext2 linux tpm
all_video gfxterm terminal echo

*******************************************************************************
### What is the origin and full version number of your bootloader (GRUB2 or other)?
*******************************************************************************
Upstream grub 2.06 with above CVE patches
https://ftp.gnu.org/gnu/grub/grub-2.06.tar.xz

*******************************************************************************
### If your SHIM launches any other components, please provide further details on what is launched.
*******************************************************************************
N/A

*******************************************************************************
### If your GRUB2 launches any other binaries that are not the Linux kernel in SecureBoot mode, please provide further details on what is launched and how it enforces Secureboot lockdown.
*******************************************************************************
N/A

*******************************************************************************
### How do the launched components prevent execution of unauthenticated code?
*******************************************************************************
Our shim will only launch our signed GRUB2, which has built-in secure-boot support. GRUB2 will only launch our signed kernel, which is configured to enable lockdown.

*******************************************************************************
### Does your SHIM load any loaders that support loading unsigned kernels (e.g. GRUB2)?
*******************************************************************************
No.
*******************************************************************************
### What kernel are you using? Which patches does it includes to enforce Secure Boot?
*******************************************************************************
Our kernel is based on 4.19 with lockdown patch and enforces lockdown.

*******************************************************************************
### Add any additional information you think we may need to validate this shim.
*******************************************************************************
N/A
