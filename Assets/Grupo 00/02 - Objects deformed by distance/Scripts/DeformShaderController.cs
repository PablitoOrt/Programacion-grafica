using UnityEngine;
using UnityEngine.UI;

public class DeformShaderController : MonoBehaviour
{
    [SerializeField] private Material deformMaterial;
    [SerializeField] private Slider heightSlider;
    [SerializeField] private Slider frequencySlider;

    private void Start()
    {
        if (deformMaterial != null)
        {
            heightSlider?.onValueChanged.AddListener(val => deformMaterial.SetFloat("_DefHeight", val));
            frequencySlider?.onValueChanged.AddListener(val => deformMaterial.SetFloat("_DefFrequency", val));
        }
    }
}
