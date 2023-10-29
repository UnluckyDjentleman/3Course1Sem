using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LeadCamera : MonoBehaviour
{
    public GameObject player;
    private Vector3 offset;

    void Start()
    {
        offset = transform.position;
    }

    void LateUpdate()
    {
        transform.position = player.transform.position + offset;
    }
}
