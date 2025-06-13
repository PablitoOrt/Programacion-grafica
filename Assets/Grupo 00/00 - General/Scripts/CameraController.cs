using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class CameraController : MonoBehaviour
{
    [Header("Movimiento")]
    public float moveSpeed = 5f;

    [Header("Rotación")]
    public float mouseSensitivity = 2f;

    private float pitch = 0f;
    private float yaw = 0f;

    void Start()
    {
        Cursor.lockState = CursorLockMode.None; // Al inicio no bloqueamos el cursor
    }

    void Update()
    {
        if (Input.GetMouseButton(1)) // Botón derecho presionado
        {
            Cursor.lockState = CursorLockMode.Locked;

            // Rotación con mouse
            float mouseX = Input.GetAxis("Mouse X") * mouseSensitivity;
            float mouseY = Input.GetAxis("Mouse Y") * mouseSensitivity;

            yaw += mouseX;
            pitch -= mouseY;
            pitch = Mathf.Clamp(pitch, -89f, 89f);

            transform.eulerAngles = new Vector3(pitch, yaw, 0f);

            // Movimiento con WASD
            float moveX = Input.GetAxis("Horizontal");
            float moveZ = Input.GetAxis("Vertical");
            Vector3 move = transform.right * moveX + transform.forward * moveZ;
            transform.position += move * moveSpeed * Time.deltaTime;
        }
        else
        {
            Cursor.lockState = CursorLockMode.None; // Libera el cursor cuando soltás el botón
        }
    }
}







