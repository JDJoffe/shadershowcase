﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(Camera))]
public class Fog : MonoBehaviour
{

    public Material shaderMaterial;
    [SerializeField, Range(5, 50)]
    float _Distance = 20;
    Vector2 depthtex;
    public float Distance
    {
        get { return _Distance; }
        set { _Distance = value; }
    }
    void Start()
    {
        
        GetComponent<Camera>().depthTextureMode = DepthTextureMode.Depth;
    }
private void Update() 
{
    
}
    void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        //Vector2 dist = new Vector2(transform.position.x, transform.position.y);
        shaderMaterial.SetFloat("_Distance", _Distance);
        Graphics.Blit(src, dest, shaderMaterial);
    }
}
