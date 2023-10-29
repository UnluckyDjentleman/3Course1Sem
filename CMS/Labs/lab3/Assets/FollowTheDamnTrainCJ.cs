using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FollowTheDamnTrainCJ : MonoBehaviour
{
    private Rigidbody rb;
    public float speed = 3f;
    // Start is called before the first frame update
    void Start()
    {
        rb = GetComponent<Rigidbody>();
    }

    // Update is called once per frame
    void Update()
    {
        float moveHor = Input.GetAxis("Vertical");
        float moveVer = Input.GetAxis("Horizontal");

        Vector3 movement = new Vector3(-moveHor, 0.0f, moveVer);
        rb.AddForce(movement * speed);
    }
}
