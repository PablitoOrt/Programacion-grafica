using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;


public class VariableManager : MonoBehaviour
{

    [Header("Distance Shader")]
    public Material distanceMaterial;
    public Slider distanceHeightSlider;
    public Slider distanceFrequencySlider;

    [Header("Deform Shader")]
    public Material deformMaterial;
    public Slider deformHeightSlider;
    public Slider deformFrequencySlider;

    [Header("Move Shader")]
    public Material moveMaterial;
    public Slider moveHeightSlider;
    public Slider moveFrequencySlider;
    public Slider moveSpeedSlider;

    [Header("Water Shader")]
    public Material waterMaterial;
    public Slider waterHeightSlider;
    public Slider waterFrequencySlider;
    public Slider waterSpeedSlider;
    public Slider waterVoronoiSlider;

    private void Start()
    {
        // Distance
        distanceHeightSlider.onValueChanged.AddListener((value) => distanceMaterial.SetFloat("_DisHeight", value));
        distanceFrequencySlider.onValueChanged.AddListener((value) => distanceMaterial.SetFloat("_DisFrequency", value));

        // Deform
        deformHeightSlider.onValueChanged.AddListener((value) => deformMaterial.SetFloat("_DefHeight", value));
        deformFrequencySlider.onValueChanged.AddListener((value) => deformMaterial.SetFloat("_DefFrequency", value));

        // Move
        moveHeightSlider.onValueChanged.AddListener((value) => moveMaterial.SetFloat("_MoveHeight", value));
        moveFrequencySlider.onValueChanged.AddListener((value) => moveMaterial.SetFloat("_MoveFrequency", value));
        moveSpeedSlider.onValueChanged.AddListener((value) => moveMaterial.SetFloat("_MoveSpeed", value));

        // Water
        waterHeightSlider.onValueChanged.AddListener((value) => waterMaterial.SetFloat("_WaterHeight", value));
        waterFrequencySlider.onValueChanged.AddListener((value) => waterMaterial.SetFloat("_WaterFrequency", value));
        waterSpeedSlider.onValueChanged.AddListener((value) => waterMaterial.SetFloat("_WaterSpeed", value));
        waterVoronoiSlider.onValueChanged.AddListener((value) => waterMaterial.SetFloat("_VoronoiScale", value));
    }
}


