﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MoveObject : MonoBehaviour
{
 
    Vector3 startPos ;
    // Start is called before the first frame update
    void Start()
    {
         startPos = transform.position;
    }

    // Update is called once per frame
    void Update()
    { 
       // transform.position =startPos + new Vector3(0,Mathf.Tan(Time.time),0);
       
      transform.position = startPos + new Vector3(0,Mathf.PingPong(Time.time,5),0);
    }
}
