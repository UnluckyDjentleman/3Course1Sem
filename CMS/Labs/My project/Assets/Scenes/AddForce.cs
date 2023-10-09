using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AddForce : MonoBehaviour
{
    public Rigidbody rb;
    // Start is called before the first frame update
    void Start()
    {

    }
    void OnCollisionEnter(Collision collision)
    {
        rb = GetComponent<Rigidbody>();
        if (collision.gameObject.tag=="LOL")
        {
            rb.AddForce(Vector3.right * 5, ForceMode.Impulse);
            Destroy(collision.gameObject, .5f);
        }
    }
    // Update is called once per frame
    void Update()
    {
        
    }
}
