provider "oci" {
  tenancy_ocid     = "ocid1.tenancy.oc1..aaaaaaaaiy2elljqezrtvaxzi3lfxakemje5ke2ldk74ftkj2ohky5a744ra"
  user_ocid        = "ocid1.user.oc1..aaaaaaaaceo5qrk7oepgwsykbyfmplty3cofd2rm2e5oirgyepbcvk5ilxrq"
  private_key_path = "/home/hp/Desktop/djbedpcelll/User-Details/piu3-djb@djb.gov.in-2026-06-15T07_40_27.479Z.pem"
  fingerprint      = "f2:9f:25:d9:d5:23:96:4b:ba:39:7b:2f:39:a5:22:b8"
  region           = "ap-mumbai-1"
}

provider "oci" {
  alias            = "home"
  tenancy_ocid     = "ocid1.tenancy.oc1..aaaaaaaaiy2elljqezrtvaxzi3lfxakemje5ke2ldk74ftkj2ohky5a744ra"
  user_ocid        = "ocid1.user.oc1..aaaaaaaaceo5qrk7oepgwsykbyfmplty3cofd2rm2e5oirgyepbcvk5ilxrq"
  private_key_path = "/home/hp/Desktop/djbedpcelll/User-Details/piu3-djb@djb.gov.in-2026-06-15T07_40_27.479Z.pem"
  fingerprint      = "f2:9f:25:d9:d5:23:96:4b:ba:39:7b:2f:39:a5:22:b8"
  region           = "ap-mumbai-1"
}