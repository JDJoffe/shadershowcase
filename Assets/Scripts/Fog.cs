using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(Camera))]
public class Fog : MonoBehaviour
{

    public Material shaderMaterial;
    [SerializeField, Range(0, 1)]
    float _Distance;
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

    void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        Vector2 dist = new Vector2(transform.position.x, transform.position.y);
        shaderMaterial.SetVector("_Distance", dist);
        Graphics.Blit(src, dest, shaderMaterial);
    }
}
