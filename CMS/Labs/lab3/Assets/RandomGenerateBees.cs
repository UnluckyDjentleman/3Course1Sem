using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RandomGenerateBees : MonoBehaviour
{
    public GameObject prefab;
    public float radius = 2f;
    public float numberOfObjects = 10;
    // Start is called before the first frame update
    void Start()
    {
        for(int i = 0; i < numberOfObjects; i++)
        {
            float angle = i * Mathf.PI * 2 / (numberOfObjects);
            float x = Mathf.Cos(angle) * radius;
            float z = Mathf.Sin(angle) * radius;
            Vector3 pos = transform.position + new Vector3(x, 1f, z);
            float angleDegrees = -angle * Mathf.Rad2Deg;
            Quaternion rot = Quaternion.Euler(90f, angleDegrees, Random.Range(180,360));
            Instantiate(prefab, pos, rot);
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
