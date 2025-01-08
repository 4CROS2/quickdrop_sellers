const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const { getFirestore } = require("firebase-admin/firestore");
const { getMessaging } = require("firebase-admin/messaging");
const admin = require("firebase-admin");

admin.initializeApp();

// Función para notificar al vendedor cuando se crea un nuevo pedido
exports.notifyNewOrder = onDocumentCreated(
  "sellers/{sellerId}/orders/{orderId}",
  async (event) => {
    const snapshot = event.data;
    const sellerId = event.params.sellerId;

    if (!snapshot.exists) {
      console.error("Datos del pedido están vacíos.");
      return;
    }

    const orderData = snapshot.data();

    try {
      // Obtener los datos del vendedor desde Firestore
      const firestore = getFirestore();
      const sellerDoc = await firestore
        .collection("sellers")
        .doc(sellerId)
        .get();

      if (!sellerDoc.exists) {
        console.error(
          // eslint-disable-next-line comma-dangle
          `El documento del vendedor con ID ${sellerId} no existe.`
        );
        return;
      }

      const sellerData = sellerDoc.data();
      const sellerToken = sellerData.fcmToken;

      if (!sellerToken) {
        console.error(
          // eslint-disable-next-line comma-dangle
          `El vendedor con ID ${sellerId} no tiene un token de notificación.`,
        );
        return;
      }

      // Crear el payload de la notificación
      const payload = {
        notification: {
          title: "Nuevo Pedido",
          body: `Tienes un nuevo pedido: ${orderData.productName}`,
        },
      };

      // Enviar la notificación
      const messaging = getMessaging();
      await messaging.sendToDevice(sellerToken, payload);
    } catch (error) {
      console.error("Error al procesar la notificación:", error);
    }
  },
);
