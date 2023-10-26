//
//   RegisterMenuView.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/10/17.
//

import SwiftUI

struct RegisterMenuView : View {
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var storeRegiVM : StoreRegisterViewModel
    
    @State var image : Image?
    @State var selectedUIImage : UIImage?
    @State var showImagePicker = false
    
    @State var TestNum : Int = 0
    @State var deleteButtonClicked = false
    
    func loadImage() {
        guard let selectedImage = selectedUIImage else { return }
        image = Image(uiImage: selectedImage)
        
        let imageData = selectedUIImage!.jpegData(compressionQuality: 0.5)! as NSData
        storeRegiVM.storeImage = imageData
    }
        
    private func deleteItem(at indexSet: IndexSet) {
        self.storeRegiVM.menuRequirName.remove(atOffsets: indexSet)
    }
    
    func removeOption(at offsets: IndexSet){
        storeRegiVM.Options.remove(atOffsets: offsets)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                
                //VStack{
                    //메뉴 사진 추가
                    
                        Button(action: {
                            showImagePicker.toggle()
                        }, label: {
                            if let image = image{
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .ignoresSafeArea(edges: .top)
                                    .frame(height: 170)
                                    .clipped()
                                    .padding(.bottom , 20)
                            }
                            else{
                                    VStack{
                                        Text("메뉴 사진 등록").foregroundColor(Color.black)
                                        Image(systemName: "plus.app.fill")
                                            .foregroundColor(Color.black)
                                            .font(.system(size: 50))
                                    }
                                .padding(.vertical, 20)
                            }


                        })
                            .sheet(isPresented: $showImagePicker, onDismiss: {
                                loadImage()
                                //imageChangeWhether = true
                            }) {
                                ImagePicker(image: $selectedUIImage)
                            }
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets())
//==============================================================================================
                    
                // 메뉴 이름
                    HStack{
                        TextField("메뉴 이름 입력", text: $storeRegiVM.menuName)
                            .frame(width: 100)
                            .textFieldStyle(PlainTextFieldStyle())
                            .fixedSize(horizontal: true, vertical: false)
                            .multilineTextAlignment(.center)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .background(borderStyleView())
                            .padding(.bottom , 10)
                        Spacer()
                    }.padding(.horizontal , 20)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)

                //메뉴 기본 가격
                    HStack{
                        Text("기본가격 ").font(.system(size:20 , weight: .bold))
                        Spacer()
                        TextField("메뉴 가격 입력", text: $storeRegiVM.menuName)
                            .frame(width: 100)
                            .textFieldStyle(PlainTextFieldStyle())
                            .fixedSize(horizontal: true, vertical: false)
                            .multilineTextAlignment(.center)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .background(borderStyleView())
                    }.padding(.horizontal , 20)

                    
                    //Divider().background(Color.black)
                //}//VStack
                .navigationBarBackButtonHidden(true)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("")
                .toolbar {
                    
                    // 2
                    ToolbarItem(placement: .navigationBarLeading) {
                        HStack{
                            Button {
                                dismiss()

                            } label: {
                                // 4
                                HStack {
                                    Image(systemName: "chevron.backward").foregroundColor(Color.black)
                                    Text("메뉴 등록").foregroundColor(Color.black)

                                }
                             }
                        }
                   }//ToolbarItem.
                }//toolbar
                .navigationBarBackground({
                    Color.white
                })
//===============================================================================================
                    VStack{
//                            ForEach(Array(storeRegiVM.menuRequirName.enumerated()), id: \.element) { index, element in
//
//                                //Text(element.description)
//                                AddMenuRequiredView(storeRegiVM : storeRegiVM , Index: index)
//                                Text("\(index)")
//                                Divider().background(Color.mint)
//                            }.onDelete(perform: deleteItem)

                        //****
                        ForEach(storeRegiVM.Requireds.indices , id:\.self){ index in
                                AddMenuRequiredView(storeRegiVM : storeRegiVM , Index: index)
                            Divider().background(Color.mint)

                        }

                }


                //필수 추가
                    Button(action: {

                        storeRegiVM.Requireds.append(Required(id: UUID(), title: ""))
                        for (index, value) in storeRegiVM.menuRequirName.enumerated() {
                            print((index, value))

                        }
                    }, label: {
                        VStack{
                            Text("필수 사항 등록").foregroundColor(Color.black)
                            Image(systemName: "plus.app.fill")
                                .foregroundColor(Color.black)
                                .font(.system(size: 50))
                        }

                    }).padding(20)

//================================================================================================
                    Divider().background(Color.black)
                    VStack{
                        ForEach(storeRegiVM.Options.indices , id:\.self){ index in
                                AddMenuOptionsView(storeRegiVM : storeRegiVM , Index: index)
                                Divider().background(Color.mint)
                        }
                    }

                //선택 추가
                    Button(action: {

                        storeRegiVM.Options.append(Option(id: UUID()))
                        for (index, value) in storeRegiVM.Options.enumerated() {
                            print((index, value))
                        }
                    }, label: {
                        VStack{
                            Text("선택 사항 등록").foregroundColor(Color.black)
                            Image(systemName: "plus.app.fill")
                                .foregroundColor(Color.black)
                                .font(.system(size: 50))
                        }

                    }).padding(20)

                    
            }.listStyle(PlainListStyle())//List

            
            MenuAddButton(storeRegiVM: storeRegiVM)
        }//ZStack
   }
}

struct MenuAddButton : View {
    @ObservedObject var storeRegiVM: StoreRegisterViewModel

    var body: some View {

        HStack{

                Button(action: {
                    //storeRegiVM.addMenu()
                }, label: {
                    HStack{
                        Text("메뉴 등록하기")
                    }
                    .font(.system(size:20 , weight: .bold))
                    .foregroundColor(Color.white)
                    .frame(width: 250, height: 50)
                }).background(Color.black)
                    .cornerRadius(10)
                    .padding(10)

        } //HStack
        .background(Color.white)
    }
}

struct AddMenuRequiredView : View {
    @ObservedObject var storeRegiVM: StoreRegisterViewModel
    var Index : Int
    @FocusState var focused: Bool
    @State var TestNum : Int = 0
    
    var body: some View {
        
        VStack {
            HStack{
                Spacer()
                
                Button(action: {
                    //storeRegiVM.Requireds[Index].RequiredLists.removeAll()
                    storeRegiVM.Requireds.remove(at: Index)
                }, label: {Image(systemName: "trash.fill")
                        .foregroundColor(Color.red)
                        .font(.system(size: 20))
                })
                
            }.padding(.trailing, 20)
            
            HStack{
                
                TextField("필수 메뉴 제목", text: Binding(get:  {  self.Index < self.storeRegiVM.Requireds.count ? self.storeRegiVM.Requireds[Index].title : "" } ,set : {storeRegiVM.Requireds[Index].title = $0}))
                        .frame(width: 100)
                        .textFieldStyle(PlainTextFieldStyle())
                        .fixedSize(horizontal: true, vertical: false)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .background(borderStyleView())
                        .padding(.bottom , 10)
                        .focused($focused)
    
                    Spacer()
                    
            }.padding(.horizontal,10) //HStack
            
            //=====================================================================
            
                if(Index < storeRegiVM.Requireds.count){
                    ForEach(storeRegiVM.Requireds[Index].RequiredLists.indices , id:\.self){ listindex in
                            AddMenuRequiredListView(storeRegiVM : storeRegiVM , Index2: Index , listIndex: listindex)
                            Divider().background(Color.orange)
                        
                    }
                }
        
            //=====================================================================
            Button(action: {
                storeRegiVM.Requireds[Index].RequiredLists.append(RequiredList(id: UUID(), title : ""))
                for (index, value) in storeRegiVM.Requireds[Index].RequiredLists.enumerated() {
                    print("index: [\(index)] / title: \(storeRegiVM.Requireds[Index].RequiredLists[index].title)")
                    print("index , value: ")
                    print((index, value))
                }
            }, label: {
                VStack{
                    Text("필수 목록 등록").foregroundColor(Color.black)
                    Image(systemName: "plus.app.fill")
                        .foregroundColor(Color.mint)
                        .font(.system(size: 30))
                }

            }).padding(20)
        }//VStack
    }
}

struct AddMenuRequiredListView : View {
    @ObservedObject var storeRegiVM: StoreRegisterViewModel
    var Index2 : Int
    var listIndex : Int
    @State var title : String = ""
    @State var price : String = ""

    init(storeRegiVM: StoreRegisterViewModel, Index2 : Int, listIndex: Int){
        self.storeRegiVM = storeRegiVM
        self.Index2 = Index2
        self.listIndex = listIndex
    }
    
    var body: some View {
        //추후 onCommit -> onEditingChanged 로 변경 포커스 받으면 false 안받으면 true 커밋
        HStack{
//            TextField("목록 입력", text: $title , onCommit: {
//                self.storeRegiVM.Requireds[self.Index2].RequiredLists[self.listIndex].title = title })
            
                TextField("목록 입력", text:  Binding(get:  {
                    self.Index2 < self.storeRegiVM.Requireds.count && self.listIndex < self.storeRegiVM.Requireds[Index2].RequiredLists.count && self.Index2 < self.storeRegiVM.Requireds[Index2].RequiredLists.count ?
                        self.storeRegiVM.Requireds[Index2].RequiredLists[listIndex].title : ""

                }
                                                  ,set : {storeRegiVM.Requireds[Index2].RequiredLists[listIndex].title = $0}))
                        .frame(width: 80)
                        .textFieldStyle(PlainTextFieldStyle())
                        .fixedSize(horizontal: true, vertical: false)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .background(borderStyleView())
                        .padding(.bottom , 10)
                        .padding(.horizontal,30)
                Spacer()

//                    .focused($focused)
            //추후 price -> Int로 형변환 바람.
            TextField("가격 입력", text: $price , onCommit: {
                self.storeRegiVM.Requireds[self.Index2].RequiredLists[self.listIndex].priceString = price
            })
                    .frame(width: 80)
                    .textFieldStyle(PlainTextFieldStyle())
                    .fixedSize(horizontal: true, vertical: false)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    .background(borderStyleView())
                    .padding(.bottom , 10)
                    .padding(.horizontal,30)
                    .keyboardType(.numberPad)

            
            Button(action: {
                storeRegiVM.Requireds[Index2].RequiredLists.remove(at: listIndex)
            }, label: {
                VStack{
                    Image(systemName: "delete.left.fill")
                        .foregroundColor(Color.red)
                        .font(.system(size: 20))
                }

            })
                
        
            
        }.padding(.trailing, 20)
        
    }
}

struct AddMenuOptionsView : View {
    @ObservedObject var storeRegiVM: StoreRegisterViewModel
    @FocusState var focused: Bool
    var Index : Int
    @State var title : String = ""
    
    var body: some View {
        VStack {
            HStack{
                Spacer()
                //Text("Index ; \(Index)")

                Button(action: {
                    storeRegiVM.Options.remove(at: Index)
                }, label: {Image(systemName: "trash.fill")
                        .foregroundColor(Color.red)
                        .font(.system(size: 20))
                })

            }.padding(.trailing, 20)
            
            HStack{
                    
                TextField("선택 메뉴 제목", text: Binding(get:  {  self.Index < self.storeRegiVM.Options.count ? self.storeRegiVM.Options[Index].title : "" } ,set : {storeRegiVM.Options[Index].title = $0}))
                        .frame(width: 100)
                        .textFieldStyle(PlainTextFieldStyle())
                        .fixedSize(horizontal: true, vertical: false)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .background(borderStyleView())
                        .padding(.bottom , 10)
                        .focused($focused)
    
                    Spacer()
                    

            }.padding(.horizontal,10) //HStack
            
            //=====================================================================
            if(Index < storeRegiVM.Options.count){
                ForEach(storeRegiVM.Options[Index].OptionsLists.indices , id:\.self){ listindex in
                        AddMenuOptionListView(storeRegiVM : storeRegiVM , Index2: Index , listIndex: listindex)
                        Divider().background(Color.orange)

                }
            }
            
//            =====================================================================
            Button(action: {
                storeRegiVM.Options[Index].OptionsLists.append(OptionList(id: UUID(), title: "OptionList"))
            }, label: {
                VStack{
                    Text("선택 목록 등록").foregroundColor(Color.black)
                    Image(systemName: "plus.app.fill")
                        .foregroundColor(Color.mint)
                        .font(.system(size: 30))
                }

            }).padding(20)
        }//VStack
    }
}

struct AddMenuOptionListView : View {
    @ObservedObject var storeRegiVM: StoreRegisterViewModel
    var Index2 : Int
    var listIndex : Int
    @State var title : String = ""
    @State var price : String = ""

    var body: some View {
        HStack{
            TextField("목록 입력", text: $title , onCommit: {
                self.storeRegiVM.Options[self.Index2].OptionsLists[self.listIndex].title = title })
                    .frame(width: 80)
                    .textFieldStyle(PlainTextFieldStyle())
                    .fixedSize(horizontal: true, vertical: false)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    .background(borderStyleView())
                    .padding(.bottom , 10)
                    .padding(.horizontal,30)
//                    .focused($focused)
            Spacer()
            //추후 price -> Int로 형변환 바람.
            TextField("가격 입력", text: $price , onCommit: {
                self.storeRegiVM.Options[self.Index2].OptionsLists[self.listIndex].priceString = price
            })
                    .frame(width: 80)
                    .textFieldStyle(PlainTextFieldStyle())
                    .fixedSize(horizontal: true, vertical: false)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    .background(borderStyleView())
                    .padding(.bottom , 10)
                    .padding(.horizontal,30)
                    .keyboardType(.numberPad)


            Button(action: {
                storeRegiVM.Options[Index2].OptionsLists.remove(at: listIndex)
            }, label: {Image(systemName: "delete.left.fill")
                    .foregroundColor(Color.red)
                    .font(.system(size: 20))
            })



        }.padding(.trailing, 20)
    }
}

struct RegiMenuView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterMenuView(storeRegiVM: StoreRegisterViewModel() )
    }
}
