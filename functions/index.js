const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const { getFirestore } = require("firebase-admin/firestore");
const { getMessaging } = require("firebase-admin/messaging");
const admin = require("firebase-admin");

admin.initializeApp();

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
          `El documento del vendedor con ID ${sellerId} no existe.`,
        );
        return;
      }

      const sellerData = sellerDoc.data();
      const sellerToken = sellerData.fcmToken;

      if (!sellerToken) {
        console.error(
          `El vendedor con ID ${sellerId} no tiene un token de notificación.`,
        );
        return;
      }

      // Crear el mensaje usando la nueva API v1
      const message = {
        token: sellerToken,
        notification: {
          title: "Nuevo Pedido",
          body: `Tienes un nuevo pedido: ${orderData.product_name}`,
        },
        // Opcional: Puedes agregar datos adicionales aquí
        data: {
          orderId: event.params.orderId,
          clickAction: "FLUTTER_NOTIFICATION_CLICK",
        },
      };

      // Enviar la notificación usando la nueva API
      const messaging = getMessaging();
      await messaging.send(message);
    } catch (error) {
      console.error("Error al procesar la notificación:", error);
    }
  },
);
