using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GreenCubes : MonoBehaviour
{
    public GameObject prefab;
    public int cubes = 30;
    // Start is called before the first frame update
    void Start()
    {
        for(int i = 0; i < cubes; i++)
        {
            Vector3 position = new Vector3(Random.Range(-75.0f, 75.0f), 0, Random.Range(-5.0f, 5.0f));
            Instantiate(prefab, position, Quaternion.identity);
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
