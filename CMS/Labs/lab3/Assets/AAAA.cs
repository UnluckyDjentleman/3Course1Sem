using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class AAAA : MonoBehaviour
{
    public Transform other;
    public float closeDistance = 5.0f;
    public float chaseSpeed = 4f;
    public float minSpeed = 1f;
    public float chaseDistance = 5f;
    // Start is called before the first frame update
    void Start()
    {
        other = GameObject.Find("Hero").transform;
    }

    // Update is called once per frame

    void Update()
    {
        if (other)
        {
            Vector3 offset = other.position - transform.position;
            float sqrLen = offset.sqrMagnitude;

            // square the distance we compare with
            if (sqrLen < closeDistance * closeDistance)
            {
                float speed = Mathf.Lerp(chaseSpeed, minSpeed, sqrLen / chaseDistance);
                transform.position += offset.normalized * speed * Time.deltaTime;
            }
        }
    }
    private void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.name == "Hero")
        {
            Destroy(collision.gameObject);
        }
    }
}
