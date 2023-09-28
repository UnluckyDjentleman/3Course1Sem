using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using static UnityEngine.GraphicsBuffer;

public class Behaviour5 : MonoBehaviour
{
    public GameObject stalker;
    public float targetDistance = 5f;
    public float speed = 5f;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        transform.LookAt(stalker.transform.position);
        if (Vector3.Distance(transform.position, stalker.transform.position) > targetDistance)
            transform.position += transform.forward * Time.deltaTime * speed;
    }
}
