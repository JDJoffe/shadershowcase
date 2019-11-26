using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Rotate : MonoBehaviour
{
    Transform mesh;
    public Vector3 rotation;
    public float rotationSpeed;
    //enum rotationSelect
    //{
    //    rotateX,
    //    rotateY,
    //    rotateZ
    //};
  // public   dropDown = rotationSelect.rotateX;
    // Start is called before the first frame update
    void Start()
    {
        mesh = gameObject.transform;
    }

    // Update is called once per frame
    void Update()
    {
        mesh.transform.Rotate(
            rotation.x * rotationSpeed * Time.deltaTime, 
            rotation.y * rotationSpeed * Time.deltaTime, 
            rotation.z * rotationSpeed * Time.deltaTime, Space.Self);

    }
}
