package main

import (
	"fmt"

	"github.com/Muzosh/liboqs-go/oqsgo"
)

func main() {
	// SIG CONSTRUCTION
	sig := oqsgo.NewOQS_SIGNATURE(oqsgo.OQS_SIG_alg_dilithium_3)
	defer oqsgo.DeleteOQS_SIGNATURE(sig)

	if sig.GetConstruct_success() != true {
		fmt.Println("Error constructing sig")
		return
	}
	fmt.Println("Signature object initialized: ", sig.GetMethod_name())

	// KEYPAIR
	public_key := make([]byte, sig.GetLength_public_key())
	private_key := make([]byte, sig.GetLength_private_key())

	status := sig.Keypair(public_key, private_key)
	if status != oqsgo.OQS_SUCCESS {
		fmt.Println("Error keypair")
		return
	}
	fmt.Println("Keypair success")

	// SIGN
	message := "Hello World"
	signature := make([]byte, sig.GetLength_signature())
	var signature_len int64

	status = sig.Sign(signature, &signature_len, message, int64(len(message)), private_key)

	if status != oqsgo.OQS_SUCCESS {
		fmt.Println("Error sign")
		return
	}
	fmt.Println("Sign success")

	// VERIFY
	status = sig.Verify(message, int64(len(message)), signature, signature_len, public_key)
	if status != oqsgo.OQS_SUCCESS {
		fmt.Println("Error verify")
		return
	}
	fmt.Println("Verify success")

	// KEM CONSTRUCTION
	kem := oqsgo.NewOQS_KEYENCAPSULATION(oqsgo.OQS_KEM_alg_kyber_1024)
	defer oqsgo.DeleteOQS_KEYENCAPSULATION(kem)

	if kem.GetConstruct_success() != true {
		fmt.Println("Error constructing kem")
		return
	}
	fmt.Println("KEM object initialized: ", kem.GetMethod_name())

	// KEYPAIR
	public_key = make([]byte, kem.GetLength_public_key())
	private_key = make([]byte, kem.GetLength_private_key())
	
	status = kem.Keypair(public_key, private_key)
	if status != oqsgo.OQS_SUCCESS {
		fmt.Println("Error keypair")
		return
	}
	fmt.Println("Keypair success")

	// ENCAPS
	shared_secret := make([]byte, kem.GetLength_shared_secret())
	ciphertext := make([]byte, kem.GetLength_ciphertext())

	status = kem.Encapsulate(ciphertext, shared_secret, public_key)
	if status != oqsgo.OQS_SUCCESS {
		fmt.Println("Error encapsulate")
		return
	}
	fmt.Println("Encapsulate success")

	// DECAPS
	shared_secret2 := make([]byte, kem.GetLength_shared_secret())

	status = kem.Decapsulate(shared_secret2, ciphertext, private_key)
	if status != oqsgo.OQS_SUCCESS {
		fmt.Println("Error decapsulate")
		return
	}
	fmt.Println("Decapsulate success")

	fmt.Println("Finished successfully")
}
