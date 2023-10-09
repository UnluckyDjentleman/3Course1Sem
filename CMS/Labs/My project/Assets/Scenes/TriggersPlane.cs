using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TriggersPlane : MonoBehaviour
{
    public GameObject go;
    private Vector3 initialScale;
    public bool isIn=false;
    void Start()
    {
        initialScale = go.transform.localScale;
    }
    void FixedUpdate()
    {
        if (isIn)
        {
            go.transform.localScale += new Vector3(0.01f, 0.01f, 0.01f);
        }
        else
        {
            go.transform.localScale = initialScale;
        }
    }
    void OnTriggerEnter(Collider other)
    {
        isIn = true;
    }
    void OnTriggerExit(Collider other)
    {
        isIn = false;
    }
}
